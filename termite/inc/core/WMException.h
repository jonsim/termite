/**
 *  \file   WMException.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _WM_EXCEPTION_H
#define _WM_EXCEPTION_H

#include <exception>
#include <string>

class WMException : std::exception
{
private:
    /** The exception's message. */
    std::string mMessage;

public:
    /**
     *  \brief  WMException constructor.
     */
    explicit WMException(const std::string& message) : mMessage(message) {}

    /**
     *  \brief  WMException destructor.
     */
    virtual ~WMException(void);

    virtual const char* what() const noexcept
    {
        return mMessage.c_str();
    }
};

#endif